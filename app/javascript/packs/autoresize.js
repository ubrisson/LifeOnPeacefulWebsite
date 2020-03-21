const autoExpand = function (field) {
    // Reset field height
    field.style.height = 'inherit';
    // Get the computed styles for the element
    const computed = window.getComputedStyle(field);
    // Calculate the height
    const height = parseInt(computed.getPropertyValue('border-top-width'), 10)
        + parseInt(computed.getPropertyValue('padding-top'), 10)
        + field.scrollHeight
        + parseInt(computed.getPropertyValue('padding-bottom'), 10)
        + parseInt(computed.getPropertyValue('border-bottom-width'), 10);
    field.style.height = height + 'px';
};
const body = document.getElementById('comment_body');
body.addEventListener('input', function (event) { autoExpand(event.target)});