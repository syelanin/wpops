
let fs = require('fs')

let max_children = process.env.max_children
let request_terminate_timeout = process.env.request_terminate_timeout
let pm = process.env.pm
let start_servers = process.env.start_servers
let min_spare_servers = process.env.min_spare_servers
let max_spare_servers = process.env.max_spare_servers
let process_idle_timeout = process.env.process_idle_timeout
let max_requests = process.env.max_requests

let src = fs.readFileSync(`${process.cwd()}/www.orig.conf`,'utf-8')
let dst = []

src.split('\n').forEach(line => {
	let r = line
	r = r.replace(/^;?pm.max_children = (.*)$/, `pm.max_children = ${max_children}`)
	r = r.replace(/^;?request_terminate_timeout = (.*)$/, `request_terminate_timeout = ${request_terminate_timeout}`)
	r = r.replace(/^;?pm = (.*)$/, `pm = ${pm}`)
	r = r.replace(/^;?pm.start_servers = (.*)$/, `pm.start_servers = ${start_servers}`)
	r = r.replace(/^;?pm.min_spare_servers = (.*)$/, `pm.min_spare_servers = ${min_spare_servers}`)
	r = r.replace(/^;?pm.max_spare_servers = (.*)$/, `pm.max_spare_servers = ${max_spare_servers}`)
	r = r.replace(/^;?pm.process_idle_timeout = (.*)$/, `pm.process_idle_timeout = ${process_idle_timeout}`)
	r = r.replace(/^;?pm.max_requests = (.*)$/, `pm.max_requests = ${max_requests}`)
	r = r.replace(/^;?security.limit_extensions = (.*)$/, `security.limit_extensions = .php .html .htm`)
	dst.push(r)
})

fs.writeFileSync(`${process.cwd()}/www.conf`, dst.join('\n'))
