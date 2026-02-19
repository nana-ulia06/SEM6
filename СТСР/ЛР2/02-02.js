var http = require("http");
var fs = require("fs");

http.createServer(function (request, response) {
    const fname = './tesla.png';
    let png = null;

    fs.stat(fname, (err, stat) => {
        if(err) {console.log('error: ', err);}
        else {
            png = fs.readFileSync(fname);
            response.writeHead(200, {'content-type': 'image/png', 'content-length': stat.size});
            response.end(png, 'binary');
        }
    })
}).listen(5000);

console.log("server is listening on port http://localhost:5000/png");