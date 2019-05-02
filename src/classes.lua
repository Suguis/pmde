-- Be sure to load all classes in the right order
_C = {}

_C.Object = require "src.classes.Object"

_C.GamestateManager = require "src.classes.GamestateManager"
_C.Dungeon = require "src.classes.Dungeon"
_C.Cell = require "src.classes.Cell"
_C.Floor = require "src.classes.Floor"
_C.GameState = require "src.classes.Gamestate"

_C.Animation = require "src.classes.Animation"
_C.DungeonPokemonAnimation = require "src.classes.DungeonPokemonAnimation"

_C.Vector = require "src.classes.Vector"
_C.MapView = require "src.classes.MapView"

_C.Pokemon = require "src.classes.Pokemon"
_C.DungeonPokemon = require "src.classes.DungeonPokemon"
_C.DungeonPokemonPlayer = require "src.classes.DungeonPokemonPlayer"
