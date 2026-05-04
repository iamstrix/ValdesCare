/**
 * init_autocomplete.js
 *
 * Reliable pattern used by all major autocomplete libs:
 *   - "mousedown + preventDefault" on the dropdown keeps the input focused.
 *   - Because the input never loses focus, blur never fires while clicking
 *     inside the dropdown, so the list stays open.
 *   - "blur + setTimeout(200ms)" on the input closes the list when the user
 *     clicks OUTSIDE (where there is no preventDefault to stop the blur).
 *   - Buttons use plain "click" listeners (not mousedown) — they fire BEFORE
 *     the 200ms blur timeout, so actions complete before the list closes.
 *   - An inline modal replaces prompt()/confirm() so no native dialog can
 *     interfere with focus.
 */
function initAutocomplete(inp, type) {
    let currentFocus = -1;
    let debounceTimer;
    let dropdown = null;

    // ── Helpers ───────────────────────────────────────────────────────────────
    function closeList() {
        if (dropdown) { dropdown.remove(); dropdown = null; }
    }

    function openList(data, val) {
        closeList();

        dropdown = document.createElement('div');
        dropdown.id  = inp.id + '-ac-list';
        dropdown.className = 'autocomplete-items';

        /**
         * KEY: mousedown + preventDefault on the dropdown container.
         * This prevents the browser from moving focus away from `inp`,
         * so `inp`'s blur never fires while the user is interacting with
         * any part of the dropdown (rows, buttons, modal — except the
         * modal's own text input which is handled specially).
         */
        dropdown.addEventListener('mousedown', function (e) {
            if (e.target.classList.contains('ac-modal-input')) return; // let modal input receive focus
            e.preventDefault();
        });

        inp.parentNode.appendChild(dropdown);

        // ── Suggestion rows ────────────────────────────────────────────────
        data.forEach(function (itemObj) {
            var item   = itemObj.name;
            var itemId = itemObj.id;

            var row = document.createElement('div');
            row.className = 'autocomplete-item-row';

            // Highlighted text
            var textSpan = document.createElement('span');
            textSpan.className = 'autocomplete-text';
            var mi = item.toLowerCase().indexOf(val.toLowerCase());
            textSpan.innerHTML = mi !== -1
                ? item.slice(0, mi) + '<strong>' + item.slice(mi, mi + val.length) + '</strong>' + item.slice(mi + val.length)
                : item;
            row.appendChild(textSpan);

            // Action buttons
            var actions = document.createElement('div');
            actions.className = 'autocomplete-actions';

            var editBtn = document.createElement('button');
            editBtn.type      = 'button';
            editBtn.className = 'autocomplete-btn-edit';
            editBtn.title     = 'Edit';
            editBtn.innerHTML = '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>';
            editBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                removeModal();
                buildModal({
                    mode: 'edit',
                    label: 'Edit suggestion:',
                    defaultValue: item,
                    onConfirm: function (newName) {
                        if (newName && newName !== item) processAction('edit', itemId, newName, item);
                    }
                });
            });

            var delBtn = document.createElement('button');
            delBtn.type      = 'button';
            delBtn.className = 'autocomplete-btn-delete';
            delBtn.title     = 'Delete';
            delBtn.innerHTML = '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>';
            delBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                removeModal();
                buildModal({
                    mode: 'confirm',
                    label: 'Delete "' + item + '" from the list?',
                    confirmClass: 'is-delete',
                    onConfirm: function () { processAction('delete', itemId, null, item); }
                });
            });

            actions.appendChild(editBtn);
            actions.appendChild(delBtn);
            row.appendChild(actions);

            // Hidden value (use appendChild — never innerHTML += which destroys handlers)
            var hidden   = document.createElement('input');
            hidden.type  = 'hidden';
            hidden.value = item;
            row.appendChild(hidden);

            // Row click = select value
            row.addEventListener('click', function (e) {
                if (e.target.closest('.autocomplete-actions')) return;
                inp.value = item;
                closeList();
            });

            dropdown.appendChild(row);
        });

        // ── "Add new" footer ───────────────────────────────────────────────
        var addNew = document.createElement('div');
        addNew.className = 'autocomplete-add-new';
        addNew.innerHTML = '+ Add "<strong>' + val + '</strong>" to database';
        addNew.addEventListener('click', function () {
            processAction('add', null, val, val);
        });
        dropdown.appendChild(addNew);
    }

    // ── Inline Modal (replaces prompt/confirm) ────────────────────────────────
    function removeModal() {
        if (dropdown) { var m = dropdown.querySelector('.ac-modal'); if (m) m.remove(); }
    }

    function buildModal(opts) {
        if (!dropdown) return;

        var modal = document.createElement('div');
        modal.className = 'ac-modal';

        var msg = document.createElement('div');
        msg.className   = 'ac-modal-msg';
        msg.textContent = opts.label;
        modal.appendChild(msg);

        var modalInput = null;
        if (opts.mode === 'edit') {
            modalInput          = document.createElement('input');
            modalInput.type     = 'text';
            modalInput.className = 'ac-modal-input';
            modalInput.value    = opts.defaultValue || '';
            modal.appendChild(modalInput);
        }

        var btns = document.createElement('div');
        btns.className = 'ac-modal-btns';

        var cancelBtn       = document.createElement('button');
        cancelBtn.type      = 'button';
        cancelBtn.className = 'ac-modal-cancel';
        cancelBtn.textContent = 'Cancel';
        cancelBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            removeModal();
            inp.focus();
        });

        var confirmBtn       = document.createElement('button');
        confirmBtn.type      = 'button';
        confirmBtn.className = 'ac-modal-confirm' + (opts.confirmClass ? ' ' + opts.confirmClass : '');
        confirmBtn.textContent = opts.mode === 'edit' ? 'Save' : 'Delete';
        confirmBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            var val = modalInput ? modalInput.value.trim() : null;
            removeModal();
            inp.focus();
            if (opts.onConfirm) opts.onConfirm(val);
        });

        btns.appendChild(cancelBtn);
        btns.appendChild(confirmBtn);
        modal.appendChild(btns);
        dropdown.appendChild(modal);

        // When modal's text input gets focus, inp blurs — cancel the close timer
        if (modalInput) {
            modalInput.addEventListener('focus', function () { clearTimeout(blurTimer); });
            modalInput.addEventListener('keydown', function (e) {
                if (e.key === 'Enter') { e.preventDefault(); confirmBtn.click(); }
                if (e.key === 'Escape') { e.preventDefault(); cancelBtn.click(); }
            });
            requestAnimationFrame(function () { modalInput.focus(); });
        }
    }

    // ── Close on blur (user clicked outside the dropdown) ─────────────────────
    var blurTimer;
    inp.addEventListener('blur', function () {
        blurTimer = setTimeout(closeList, 200);
    });
    inp.addEventListener('focus', function () {
        clearTimeout(blurTimer);
    });

    // ── Input event ───────────────────────────────────────────────────────────
    inp.addEventListener('input', function () {
        var val = this.value;
        closeList();
        if (!val) return;
        currentFocus = -1;

        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(function () {
            if (inp.value !== val) return;
            fetch('../api/autocomplete.php?type=' + type + '&q=' + encodeURIComponent(val))
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    if (inp.value !== val) return;
                    openList(data, val);
                })
                .catch(function (err) { console.error('Autocomplete error:', err); });
        }, 300);
    });

    // ── Keyboard navigation ───────────────────────────────────────────────────
    inp.addEventListener('keydown', function (e) {
        if (!dropdown) return;
        var rows = dropdown.querySelectorAll('.autocomplete-item-row');

        if (e.key === 'ArrowDown') {
            e.preventDefault();
            currentFocus = Math.min(currentFocus + 1, rows.length - 1);
            setActive(rows);
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            currentFocus = Math.max(currentFocus - 1, 0);
            setActive(rows);
        } else if (e.key === 'Enter') {
            e.preventDefault();
            if (currentFocus >= 0 && rows[currentFocus]) rows[currentFocus].click();
        } else if (e.key === 'Escape') {
            closeList();
        }
    });

    function setActive(rows) {
        rows.forEach(function (r, i) {
            r.classList.toggle('autocomplete-active', i === currentFocus);
        });
    }

    // ── AJAX helper ───────────────────────────────────────────────────────────
    function processAction(action, id, name, originalName) {
        fetch('../api/suggestion_action.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action: action, type: type, id: id, name: name })
        })
        .then(function (r) { return r.json(); })
        .then(function (data) {
            var label = type === 'diagnosis' ? 'Diagnosis' : 'Chief Complaint';
            if (data.success) {
                if (action === 'add') {
                    inp.value = name;
                    closeList();
                    showToast('"' + name + '" added to ' + label + ' list.', true);
                } else if (action === 'edit') {
                    showToast('"' + originalName + '" updated to "' + name + '".', true);
                    inp.dispatchEvent(new Event('input', { bubbles: true }));
                } else if (action === 'delete') {
                    showToast('"' + originalName + '" removed from ' + label + ' list.', true);
                    closeList();
                }
            } else {
                showToast(data.error || 'Action failed. Please try again.', false);
            }
        })
        .catch(function () { showToast('Network error. Please try again.', false); });
    }

    // ── Toast notification ────────────────────────────────────────────────────
    function showToast(message, isSuccess) {
        var old = document.getElementById('ac-toast');
        if (old) old.remove();

        var toast       = document.createElement('div');
        toast.id        = 'ac-toast';
        toast.className = 'ac-toast ' + (isSuccess ? 'ac-toast-success' : 'ac-toast-error');
        toast.innerHTML = '<span class="ac-toast-icon">' + (isSuccess ? '✓' : '✗') + '</span><span>' + message + '</span>';
        document.body.appendChild(toast);

        requestAnimationFrame(function () {
            requestAnimationFrame(function () { toast.classList.add('ac-toast-visible'); });
        });
        setTimeout(function () {
            toast.classList.remove('ac-toast-visible');
            setTimeout(function () { if (toast.parentNode) toast.remove(); }, 400);
        }, 3000);
    }
}

// ── Initialise ────────────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', function () {
    var cc = document.getElementById('chief_complaint');
    var dx = document.getElementById('diagnosis');
    if (cc) initAutocomplete(cc, 'complaint');
    if (dx) initAutocomplete(dx, 'diagnosis');
});