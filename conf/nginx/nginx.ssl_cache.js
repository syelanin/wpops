
let fs = require('fs')

let domain = process.env.domain
let fastcgi_cache_size = process.env.fastcgi_cache_size // 100m
let fastcgi_cache_max_size = process.env.fastcgi_cache_max_size // 2g
let fastcgi_cache_inactive = process.env.fastcgi_cache_inactive // 60m
let fastcgi_cache_valid = process.env.fastcgi_cache_valid // 60m
let php_version = process.env.php_version


let src = fs.readFileSync(`${process.cwd()}/nginx.ssl_cache.conf`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/\{domain\}/g, domain)
	r = r.replace(/\{fastcgi_cache_size\}/g, fastcgi_cache_size)
	r = r.replace(/\{fastcgi_cache_max_size\}/g, fastcgi_cache_max_size)
	r = r.replace(/\{fastcgi_cache_inactive\}/g, fastcgi_cache_inactive)
	r = r.replace(/\{fastcgi_cache_valid\}/g, fastcgi_cache_valid)
	r = r.replace(/\{php_version\}/g, php_version)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/${domain}-ssl-cache.conf`, dst.join('\n'))
