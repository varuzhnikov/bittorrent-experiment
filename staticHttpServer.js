var sys = require("sys"),
	http = require("http"),
	url = require("url"),
	path = require("path"),
	fs = require("fs");

http.createServer(function (request, response) {
	var uri = url.parse(request.url).pathname;
	var filename = path.join(process.cwd(), uri);
	path.exists(filename, function  (exists) {
		if (!exists) {
			response.writeHeader(404, {"Content-Type": "text/plain"});
			response.write("404 Not Found\n");
			return;
		};

		fs.stat(filename, function (err, stats) {
			if (err) {
				response.writeHeader(500, {"Content-Type": "text/plain"});
				response.write(err + "\n");
				response.end();
			};

			response.writeHead(200, {
				'Content-Type': 'binary/octer-stream',
				'Content-Length': stats.size
			});

			var binaryStream = fs.createReadStream(filename);

			binaryStream.on("error", function (err) {
				if (err) {
					response.writeHeader(500, {"Content-Type": "text/plain"});
					response.write(err + "\n");
					response.end();
					binaryStream.destroy();
					return;	
				}		
			});

			binaryStream.on("end", function() {
				response.writeHeader(200);
				response.end();
			});

			binaryStream.pipe(response);
		});
	})
}).listen(8081);
