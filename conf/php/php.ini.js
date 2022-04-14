
let fs = require('fs')

let memory_limit = process.env.memory_limit
let max_execution_time = process.env.max_execution_time
let max_input_time = process.env.max_input_time
let max_input_vars = process.env.max_input_vars
let post_max_size = process.env.post_max_size
let upload_max_filesize = process.env.upload_max_filesize

let src = fs.readFileSync(`${process.cwd()}/php.orig.ini`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/^;?memory_limit = (.*)$/, `memory_limit = ${memory_limit}`)
	r = r.replace(/^;?max_execution_time = (.*)$/, `max_execution_time = ${max_execution_time}`)
	r = r.replace(/^;?max_input_time = (.*)$/, `max_input_time = ${max_input_time}`)
	r = r.replace(/^;?max_input_vars = (.*)$/, `max_input_vars = ${max_input_vars}`)
	r = r.replace(/^;?post_max_size = (.*)$/, `post_max_size = ${post_max_size}`)
	r = r.replace(/^;?upload_max_filesize = (.*)$/, `upload_max_filesize = ${upload_max_filesize}`)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/php.ini`, dst.join('\n'))
