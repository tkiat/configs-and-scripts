javascript: (function() {
/* fetch urls */
const list=[];
const a=document.getElementsByTagName('img');
for (var i=0,l=a.length;i<l;i++) {
    if (/\.(jpg|gif|png|jpeg)$/im.test(a[i].getAttribute('src')))
    {
        list.push(a[i].getAttribute('src'));
    }
}

/* copy to clipboard */
const dummy = document.createElement("textarea");
document.body.appendChild(dummy);
dummy.value = list.join(' ');
dummy.select();
document.execCommand("copy");
document.body.removeChild(dummy);
})()
