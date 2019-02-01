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
  if (argv.length < 3) {
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
  const tmpPath = path.join(os.tmpdir(), `${schoolId}-${uid()}.png`);
  const outPath = path.join(__dirname, 'screens', `${schoolId}.png`);
  const dimScale = 100;
  const dims = calcDims(dimScale);


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
  await page.goto(`http://localhost:${server.address().port}`, { waitUntil: 'networkidle0' });
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
        height: Math.round(dims.height * dims.ratio),
      })
      .toFile(outPath)
  );

  fs.unlinkSync(tmpPath);

}; main();


function startServer() {
  const serveFile = serveStatic('build', {index: ['index.html']});

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
    width: 9,
    height: 6,
  };

  return {
    base,
    width: base.width * scale,
    height: base.height * scale,
    ratio: base.height / base.width,
  };
}
