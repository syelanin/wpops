
let fs = require('fs')

let db = process.env.db_name
let pass = process.env.db_pass

let src = fs.readFileSync(`${process.cwd()}/mysql.db.sql`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/\{db\}/g, db)
	r = r.replace(/\{pass\}/g, pass)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/db.sql`, dst.join('\n'))
