var createGame = require('voxel-engine')

var game = createGame()
game.appendTo(document.body)

var createplayer = require("voxel-player")(game)

var player = createplayer("player.png")
player.possess()
player.yaw.position.set(0, 100, 0)
