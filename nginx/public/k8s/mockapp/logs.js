
const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');

var mock = require('./mock');

var app = express()

app.use(cors())
app.use(cookieParser())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())


app.disable('etag');
app.use('/mockapp', mock);
app.pos
const PORT = 3000
app.listen(PORT,()=>{
    console.info(`server up at port: ${PORT}`) 
})

const updateApi = () => {
	async function asyncFunction() {
		try {
			console.log(app);
		} catch (error) {
			console.error(uri, error);
		}
	}
	asyncFunction();
}

setInterval(updateApi, 500);