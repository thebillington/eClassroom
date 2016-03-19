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
function work() {
        reset();
        document.getElementById("work").style.visibility = "visible";
        document.getElementById("workOp").style.backgroundColor = "#555";
    }
function deleteUser() {
        reset();
        document.getElementById("delete").style.visibility = "visible";
        document.getElementById("deleteOp").style.backgroundColor = "#555";
    }
function reset() {
        document.getElementById("profileView").style.visibility = "hidden";
        document.getElementById("profileEdit").style.visibility = "hidden";
        document.getElementById("classes").style.visibility = "hidden";
        document.getElementById("work").style.visibility = "hidden";
        document.getElementById("delete").style.visibility = "hidden";
        document.getElementById("viewOp").style.backgroundColor = "transparent";
        document.getElementById("editOp").style.backgroundColor = "transparent";
        document.getElementById("classesOp").style.backgroundColor = "transparent";
        document.getElementById("workOp").style.backgroundColor = "transparent";
        document.getElementById("deleteOp").style.backgroundColor = "transparent";
    }