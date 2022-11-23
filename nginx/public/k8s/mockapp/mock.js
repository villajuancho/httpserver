
const express = require('express');
const router = express.Router();


//curl -X POST http://localhost:3000/mockapp/reply -d hola=juan


router.post('/reply', (req, res) => {

	res.json({
		status: true,
		text: 'ok',
		data: req.body
	})
});


module.exports = router;