var fs = require("fs");

function getPositve(p, q){
    if(q ==null) q =1;

    if( p < -100000 )
    {
        p = -p
    };

    if( p > 100) {
        p = p - 100;
    }
    return p + q/q;
}

exports.getPositve = getPositve;