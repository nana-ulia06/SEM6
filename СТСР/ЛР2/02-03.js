var http = require("http");

http.createServer(function (request, response) {
    if (request.method == 'GET') {
        response.writeHead(200, {'content-type': 'text/plain; charset=utf-8'});
        response.end('Дужик Ульяна Сергеевна');
    }
}).listen(5000);

console.log("server is listening on port http://localhost:5000/api/name");