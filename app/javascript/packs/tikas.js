let folded = true;
document.getElementById("FoldBtn").onclick = function () {
    let details = document.getElementsByClassName("tika_details");
    for (let i = 0; i < details.length; i++) {
        details[i].open = folded;
    }
    folded = !folded;
};