const path = require('path')
const promisify = require('util').promisify
const exec = promisify(require('child_process').exec)

const scripts = [
  'osx-setup.sh',
  'osx-security.sh'
]

async function execScript (filename) {
  try {
    const { stdout, stderr } = await exec(`./${path.resolve(__dirname, filename)}`)
    console.log('stdout:', stdout)
    console.log('stderr:', stderr)
  } catch (err) {
    console.error(err)
  }
}

async function main () {
  await Promise.all(scripts.map(execScript))
}

main()
