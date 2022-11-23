const archiveName = 'FullFeaturedStart'

const fileList = [
    'locale/en/en.cfg',
    'locale/ru/ru.cfg',
    'changelog.txt',
    'control.lua',
    'data.lua',
    'data-final-fixes.lua',
    'info.json',
    'LICENSE',
    'settings.lua',
    'thumbnail.png',
]

const fs = require('fs')
const archiver = require('archiver')
const zipFile = `out/${archiveName}.zip`

if (fs.existsSync(zipFile)) {
    fs.unlinkSync(zipFile)
}
const output = fs.createWriteStream(zipFile);
const archive = archiver('zip', {decodeStrings: false, zlib: {level: 9}});
const parsedTxtFiles = {}

archive.on('error', function (err) {
    throw err;
});

archive.pipe(output);

for (let fn of fileList) {
    if (/^locale\/.*\.cfg$/) {
        prepareLocaleCfg('../' + fn)
    }
    if (/\.lua$/.test(fn)) {
        archive.append(getLuaContent('../' + fn), {name: `${archiveName}/${fn}`})
    } else {
        archive.file('../' + fn, {name: `${archiveName}/${fn}`})
    }
}
archive.finalize();

function parseTxtFile(fileName) {
    if (parsedTxtFiles.hasOwnProperty(fileName)) {
        return parsedTxtFiles[fileName]
    }
    let parsed = {}
    let lines = fs.readFileSync(fileName).toString("utf8").split(/\n/g)
    let head = null
    for (let line of lines) {
        let r = /^#####\s*([^#]+)$/.exec(line)
        if (r) {
            head = r[1].trim()
        } else if (head) {
            if (!parsed[head]) {
                parsed[head] = line.trim()
            } else {
                parsed[head] = parsed[head] + "\n" + line.trim()
            }
        }
    }
    for (let key in parsed) {
        if (parsed.hasOwnProperty(key)) {
            parsed[key] = parsed[key].trim().replace(/\n/g, "\\n")
        }
    }
    for (let key in parsed) {
        if (parsed.hasOwnProperty(key)) {
            parsed[key] = parsed[key].replace(/##([^#]+)##/g, (_, r) => parsed[r])
        }
    }
    parsedTxtFiles[fileName] = parsed
    return parsed
}

function prepareLocaleCfg(fileName) {
    let oldContents = fs.readFileSync(fileName).toString("utf8")
    let contents = oldContents.split('\n')
    let newValue = null
    for (let i = 0; i < contents.length; i++) {
        let line = contents[i];
        let r = /^#from:(.*)#(.*)$/.exec(line)
        if (r) {
            newValue = (parseTxtFile(fileName.replace(/[^/]+$/, '') + r[1])[r[2]] || "?").replace(/\n/g, "\\n")
        } else if (newValue) {
            contents[i] = line.replace(/^([^=]+)=.*$/, (_, n) => n + "=" + newValue)
            newValue = null
        }
    }
    let newContents = contents.join('\n')
    if (oldContents !== newContents) {
        fs.writeFileSync(fileName, newContents)
        console.log("File updated: ", fileName)
    }
}

function getLuaContent(fileName) {
    return fs.readFileSync(fileName).toString("utf8")
        .replace(/--\[\[DEBUG]]/g, '-- [[DEBUG]]') // Comment --[[DEBUG]]-s
}
