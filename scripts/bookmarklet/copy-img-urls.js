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

// bookmarklet

javascript:(function()%7B%2F*%20fetch%20urls%20*%2Fconst%20list%3D%5B%5D%3Bconst%20a%3Ddocument.getElementsByTagName('img')%3Bfor%20(var%20i%3D0%2Cl%3Da.length%3Bi%3Cl%3Bi%2B%2B)%20%7Bif%20(%2F%5C.(jpg%7Cgif%7Cpng%7Cjpeg)%24%2Fim.test(a%5Bi%5D.getAttribute('src')))%7Blist.push(a%5Bi%5D.getAttribute('src'))%3B%7D%7D%2F*%20copy%20to%20clipboard%20*%2Fconst%20dummy%20%3D%20document.createElement(%22textarea%22)%3Bdocument.body.appendChild(dummy)%3Bdummy.value%20%3D%20list.join('%20')%3Bdummy.select()%3Bdocument.execCommand(%22copy%22)%3Bdocument.body.removeChild(dummy)%7D)()
