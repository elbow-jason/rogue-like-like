
#init the app
rogueLikeLike = angular.module 'rogueLikeLike', []

rogueLikeLike.value 'boardConfig', {
  xLimit: 512  # how many pixels the board is in x coord
  yLimit: 512  # how many pixels the board is in y coord
  spacing: 8    # the spacing of each tile
}
