/*
 * Render
 */

'use strict';

const fs          = require('fs');
const os          = require('os');
const http        = require('http');
const path        = require('path');
const sharp       = require('sharp');
const final       = require('finalhandler');
const crypto      = require('crypto');
const puppeteer   = require('puppeteer');
const serveStatic = require('serve-static');

const { argv, exit } = process;


async function main() {

  // Startup
  if (argv.length < 4) {
    exit(1);
  }

  try {
    var server = startServer();
  }
  catch(e) {
    exit(1);
  }


  // Setup Environment
  const schoolId = argv[2];
  const outDir = argv[3];
  const tmpPath = path.join(os.tmpdir(), `${schoolId}-${uid()}.png`);
  const outPath = path.resolve(outDir, `${schoolId}.png`);
  const resolution = 120;
  const dims = calcDims(resolution);


  // Launch Browser
  const browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox'] ,
  });
  const page = await browser.newPage();
  await page.setViewport(dims);
  await page.evaluateOnNewDocument(schid => {
    window.endpoint = `/data/${schid}.json`;
    window.staticRender = true;
  }, schoolId);
  await page.goto(`http://0.0.0.0:${server.address().port}`, { waitUntil: 'networkidle0' });

  await sleep(1000);

  await page.screenshot({ path: tmpPath });
  await browser.close();

  server.close();


  // Crop Image
  await (
    sharp(tmpPath)
      .extract({
        left: 0,
        top: 0,
        width: dims.width,
        height: dims.height, //Math.round(dims.height * dims.ratio),
      })
      .toFile(outPath)
  );

  fs.unlinkSync(tmpPath);

}; main();


function sleep(ms) {
  return new Promise(res => {setTimeout(res, ms)});
}


function startServer() {
  const serveFile = serveStatic(path.join(__dirname, 'build'), {index: ['index.html']});

  return (
    http
      .createServer((req, res) => serveFile(req, res, final(req, res)))
      .listen(0) // listen 0 for random port
  );
}


function uid() {
  const len = 8;

  return (
    crypto
      .randomBytes(len/2)
      .toString('hex')
      .slice(0, len)
  );
}


function calcDims(scale) {
  const base = {
    width: 8.5,
    height: 11,
  };

  return {
    base,
    width: base.width * scale,
    height: base.height * scale,
    ratio: base.height / base.width,
  };
}
