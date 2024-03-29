function drawAxis() {
    let h = canvas.height;
    let w = canvas.width;
    ctx.strokeStyle = "black";
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(w/2, h);
    ctx.lineTo(w/2, 0);
    ctx.lineTo(w/2+3, 7);
    ctx.moveTo(w/2, 0);
    ctx.lineTo(w/2-3, 7);
    drawDigitsX(ctx, i, w, h);
    ctx.stroke();
    ctx.beginPath();
    ctx.moveTo(0, h/2);
    ctx.lineTo(w, h/2);
    ctx.lineTo(w-7, h/2+3);
    ctx.moveTo(w, h/2);
    ctx.lineTo(w-7, h/2-3);
    drawDigitsY(ctx, i, w, h);
    ctx.stroke();/*
    ctx.strokeStyle = "grey";
    ctx.lineWidth = 1;
    ctx.moveTo(w/2-5*i, h/2-3*i);
    ctx.lineTo(w/2+5*i, h/2-3*i);
    ctx.lineTo(w/2+5*i, h/2+5*i);
    ctx.lineTo(w/2-5*i, h/2+5*i);
    ctx.lineTo(w/2-5*i, h/2-3*i);
    ctx.stroke();*/
}
function drawDigitsX(ctx, i, w, h) {
    let t=w/2;
    for (let j=0; j<5; j++){
        t+=i;
        ctx.moveTo(t, h/2+3);
        ctx.lineTo(t, h/2-3)
    }
    t=w/2;
    for (let j=0; j<5; j++){
        t-=i;
        ctx.moveTo(t, h/2+3);
        ctx.lineTo(t, h/2-3)
    }
}
function drawDigitsY(ctx, i, w, h) {
    let t=h/2;
    for (let j=0; j<5; j++){
        t+=i;
        ctx.moveTo(w/2+3, t);
        ctx.lineTo(w/2-3, t);
    }
    t=h/2;
    for (let j=0; j<5; j++){
        t-=i;
        ctx.moveTo(w/2+3, t);
        ctx.lineTo(w/2-3, t);
    }
}
function drawArea(r) {
    let h = canvas.height;
    let w = canvas.width;
    ctx.strokeStyle = "#0000ff";
    ctx.fillStyle = "#0000ff";
    if (r===2){
        ctx.strokeStyle = "#00ff00";
        ctx.fillStyle = "#00ff00";
    }
    if (r===3){
        ctx.strokeStyle = "#ff0000";
        ctx.fillStyle = "#ff0000";
    }
    if (r===4){
        ctx.strokeStyle = "#00ffff";
        ctx.fillStyle = "#00ffff";
    }
    if (r===5){
        ctx.strokeStyle = "#ffff00";
        ctx.fillStyle = "#ffff00";
    }

    ctx.beginPath();
    ctx.arc(w/2,h/2,r/2*i,Math.PI/2,Math.PI,false);
    ctx.moveTo(w/2-r/2*i, h/2);
    ctx.lineTo(w/2, h/2-r*i);
    ctx.lineTo(w/2, h/2);
    ctx.lineTo(w/2+r*i, h/2);
    ctx.lineTo(w/2+r*i, h/2+r*i);
    ctx.lineTo(w/2, h/2+r*i);
    ctx.lineTo(w/2,h/2+r/2*i)
    ctx.fill();
}
function drawPoint(x, y, color) {
    ctx.fillStyle = color;
    ctx.beginPath();
    ctx.arc(canvas.width/2+x*i,canvas.height/2-y*i,2,0,Math.PI*2, true);
    ctx.fill();
}

function drawPointsFromTable() {

    console.log("qwertyui");
    let table = document.getElementById("result-table");
    //if(document.getElementsByTagName("tbody")[0]){table = document.getElementsByTagName("tbody")[0]}
    if(table){
        for(let i=1; i<table.children.length; i++){
            let row = table.children[i];
            if(row.id!=="table-headers"&&Number(row.children[2].innerText)!==Number(rField.value)){
                console.log(Number(row.children[2].innerText));
                doAjax(row.children[0].innerText, row.children[1].innerText, rField, false)
            }
            else if(row.id!=="table-headers"){
                console.log(Number(row.children[2].innerText));
                drawPoint(Number(row.children[0].innerText), Number(row.children[1].innerText), (row.children[3].innerText==="Да" ? "lime":"red"));
            }
        }
    }
};