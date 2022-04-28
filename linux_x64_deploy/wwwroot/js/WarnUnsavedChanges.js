//https://stackoverflow.com/a/48238659/11416150
"use strict";
(() => {
    const modified_inputs = new Set;
    const defaultValue = "defaultValue";
    // store default values
    addEventListener("beforeinput", (evt) => {
        const target = evt.target;
        if (!(defaultValue in target || defaultValue in target.dataset)) {
            target.dataset[defaultValue] = ("" + (target.value || target.textContent)).trim();
        }
    });
    // detect input modifications
    addEventListener("input", (evt) => {
        const target = evt.target;
        if (!$(target).hasClass("noWarn")) {
            let original;
            if (defaultValue in target) {
                original = target[defaultValue];
            } else {
                original = target.dataset[defaultValue];
            }
            if (original !== ("" + (target.value || target.textContent)).trim()) {
                if (!modified_inputs.has(target)) {
                    modified_inputs.add(target);
                }
            } else if (modified_inputs.has(target)) {
                modified_inputs.delete(target);
            }
        }
    });
    addEventListener("beforeunload", (evt) => {
        var warn = $($(evt.srcElement)[0].activeElement).hasClass("noWarn");
        if (modified_inputs.size && !warn) {
            const unsaved_changes_warning = "Changes you made may not be saved.";
            evt.returnValue = unsaved_changes_warning;
            return unsaved_changes_warning;
        }
    });
})();
