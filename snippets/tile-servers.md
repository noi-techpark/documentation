<!--
SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Tile Server](#tile-server)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Tile Server

- Normally we use a free plan on CartoDB
  - Example: `https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png`
- Other tile servers can be used as well, but they should be free of charge and should not need API keys
  - If you really need one with an API key, then the access to that key must be granted to NOI/Tech Transfer Digital Department
- Do not forget to add an attribution
  - Example, `&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, &copy; <a href="https://carto.com/attribution">CARTO</a>`
- Additional information: https://wiki.openstreetmap.org/wiki/Tile_servers
- Example previewer for tiles: https://mc.bbbike.org/mc/?lon=11.134884&lat=46.648166&zoom=9&num=8
