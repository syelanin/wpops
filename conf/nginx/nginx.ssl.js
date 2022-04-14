
let fs = require('fs')

let domain = process.env.domain
let php_version = process.env.php_version

let src = fs.readFileSync(`${process.cwd()}/nginx.ssl.conf`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/\{domain\}/g, domain)
	r = r.replace(/\{php_version\}/g, php_version)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/${domain}-ssl.conf`, dst.join('\n'))
