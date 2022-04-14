
let fs = require('fs')

let memory = process.env.redis_memory

let src = fs.readFileSync(`${process.cwd()}/redis.orig.conf`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/^(# )?maxmemory (.*)$/, `maxmemory ${memory}`)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/redis.conf`, dst.join('\n'))
