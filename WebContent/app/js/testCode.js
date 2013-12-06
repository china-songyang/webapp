var __codes = ['3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','M','N','P','Q','R','S','T','U','V','W','X','Y'];

function __getTestCode() {
	var testCode = '';
	for (var i = 0; i < 4; ++i) {
		var random = Math.round(12345 * Math.random() % __codes.length);
		var code = __codes[random];
		
		if (typeof(code) == "undefined") {
			code = 'A';
		}
		
		testCode += code;
	}
	
	return testCode;
}


		

