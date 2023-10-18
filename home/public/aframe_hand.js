function setup(hand) {
    hand.addEventListener("pinchmoved", function(event) {
        // var sphere = document.getElementById("sphere");
        // rightHand.detail.
        //     sphere.setAttribute("position", event.detail.position);
    });
}

window.addEventListener("load", (event) => {
    setup(document.getElementById("rightHand"));
    setup(document.getElementById("leftHand"));
});

