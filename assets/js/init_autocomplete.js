function initAutocomplete(inp, type) {
    let currentFocus;
    let debounceTimer;

    inp.addEventListener("input", function (e) {
        let val = this.value;
        closeAllLists();
        if (!val) { return false; }
        currentFocus = -1;

        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            if (inp.value !== val) return;

            fetch(`../api/autocomplete.php?type=${type}&q=${encodeURIComponent(val)}`)
                .then(res => res.json())
                .then(data => {
                    if (inp.value !== val) return;
                    closeAllLists();

                    let a = document.createElement("DIV");
                    a.setAttribute("id", this.id + "autocomplete-list");
                    a.setAttribute("class", "autocomplete-items");
                    this.parentNode.appendChild(a);

                    data.forEach(itemObj => {
                        let item = itemObj.name;
                        let itemId = itemObj.id;

                        let b = document.createElement("DIV");
                        b.className = "autocomplete-item-row";

                        // Create text span
                        let textSpan = document.createElement("SPAN");
                        textSpan.className = "autocomplete-text";
                        let matchIdx = item.toLowerCase().indexOf(val.toLowerCase());
                        if (matchIdx !== -1) {
                            textSpan.innerHTML = item.substring(0, matchIdx) + "<strong>" + item.substring(matchIdx, matchIdx + val.length) + "</strong>" + item.substring(matchIdx + val.length);
                        } else {
                            textSpan.innerHTML = item;
                        }
                        b.appendChild(textSpan);

                        // Create Action Buttons (Edit / Delete)
                        let actionsDiv = document.createElement("DIV");
                        actionsDiv.className = "autocomplete-actions";

                        let editBtn = document.createElement("BUTTON");

                        editBtn.innerHTML = `<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>`;
                        editBtn.className = "autocomplete-btn-edit";
                        editBtn.title = "Edit";
                        editBtn.onclick = function (e) {
                            e.stopPropagation();
                            let newName = prompt("Edit suggestion:", item);
                            if (newName && newName !== item) {
                                processAction('edit', type, itemId, newName);
                            }
                        };

                        let delBtn = document.createElement("BUTTON");
                        delBtn.innerHTML = `<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>`;
                        delBtn.className = "autocomplete-btn-delete";
                        delBtn.title = "Delete";
                        delBtn.onclick = function (e) {
                            e.stopPropagation();
                            if (confirm(`Are you sure you want to delete "${item}"?`)) {
                                processAction('delete', type, itemId, null);
                            }
                        };

                        actionsDiv.appendChild(editBtn);
                        actionsDiv.appendChild(delBtn);
                        b.appendChild(actionsDiv);

                        // Hidden input for the actual value
                        b.innerHTML += `<input type='hidden' value='${item.replace(/'/g, "&#39;")}' />`;

                        // Item Selection
                        b.addEventListener("click", function (e) {
                            inp.value = this.getElementsByTagName("input")[0].value;
                            closeAllLists();
                        });

                        a.appendChild(b);
                    });

                    // Add "Add New..." constant item at the bottom
                    let addNewDiv = document.createElement("DIV");
                    addNewDiv.className = "autocomplete-add-new";
                    addNewDiv.innerHTML = `+ Add "<strong>${val}</strong>" to database`;
                    addNewDiv.addEventListener("click", function (e) {
                        e.stopPropagation();
                        processAction('add', type, null, val);
                    });
                    a.appendChild(addNewDiv);
                })
                .catch(err => console.error("Fetch error:", err));
        }, 300); // 300ms debounce
    });

    inp.addEventListener("keydown", function (e) {
        let x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByClassName("autocomplete-item-row");

        if (e.keyCode == 40) { // Arrow DOWN
            currentFocus++;
            addActive(x);
        } else if (e.keyCode == 38) { // Arrow UP
            currentFocus--;
            addActive(x);
        } else if (e.keyCode == 13) { // ENTER
            e.preventDefault();
            if (currentFocus > -1) {
                if (x && x.length > 0) x[currentFocus].click();
            }
        }
    });

    function addActive(x) {
        if (!x || x.length === 0) return false;
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        x[currentFocus].classList.add("autocomplete-active");
    }

    function removeActive(x) {
        for (let i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }

    function closeAllLists(elmnt) {
        let x = document.getElementsByClassName("autocomplete-items");
        for (let i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }

    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });

    // Helper function to handle AJAX calls for Add/Edit/Delete
    function processAction(action, type, id, name) {
        fetch('../api/suggestion_action.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action, type, id, name })
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    if (action === 'add') {
                        inp.value = name; // Autofill the box with the newly added word
                        closeAllLists();
                    } else {
                        // Re-trigger the input event to reload the list dynamically
                        inp.dispatchEvent(new Event('input', { bubbles: true }));
                    }
                } else {
                    alert("Action failed.");
                }
            });
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const complaintInput = document.getElementById("chief_complaint");
    const diagnosisInput = document.getElementById("diagnosis");

    if (complaintInput) initAutocomplete(complaintInput, 'complaint');
    if (diagnosisInput) initAutocomplete(diagnosisInput, 'diagnosis');
});