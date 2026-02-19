var http = require("http");
var fs = require("fs");

http.createServer(function (request, response) {
    if (request.url === "/jquery") {
        let html = fs.readFileSync('./jquery.html');
        response.writeHead(200, {'content-type' : 'text/html; charset=utf-8'});
        response.end(html);
    } 
    else if (request.url === "/api/name" && request.method === 'GET') {
        response.writeHead(200, {'content-type': 'text/plain; charset=utf-8'});
        response.end('Дужик Ульяна Сергеевна');
    }
}).listen(5000);

console.log("server is listening on port http://localhost:5000/jquery");