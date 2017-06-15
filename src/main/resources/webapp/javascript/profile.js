function view() {
    reset();
    document.getElementById("profileView").style.visibility = "visible";
    document.getElementById("viewOp").style.backgroundColor = "#555";
}
function edit() {
    reset();
    document.getElementById("profileEdit").style.visibility = "visible";
    document.getElementById("editOp").style.backgroundColor = "#555";
}
function classes() {
    reset();
    document.getElementById("classes").style.visibility = "visible";
    document.getElementById("classesOp").style.backgroundColor = "#555";
}  
function reset() {
    document.getElementById("profileView").style.visibility = "hidden";
    document.getElementById("profileEdit").style.visibility = "hidden";
    document.getElementById("classes").style.visibility = "hidden";
    document.getElementById("viewOp").style.backgroundColor = "transparent";
    document.getElementById("editOp").style.backgroundColor = "transparent";
    document.getElementById("classesOp").style.backgroundColor = "transparent";
}