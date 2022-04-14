
let fs = require('fs')

let db_name = process.env.db_name
let db_pass = process.env.db_pass

let src = fs.readFileSync(`${process.cwd()}/wp.vars.conf`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/\{db_name\}/g, db_name)
	r = r.replace(/\{db_pass\}/g, db_pass)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/wp.vars-db.conf`, dst.join('\n'))
