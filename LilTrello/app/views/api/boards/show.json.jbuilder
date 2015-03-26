# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list
json.extract! @board, :title, :user_id, :lists

json.lists @board.lists, :title, :ord, :cards, :id

# json.board @board, partial: 'boards/board', as: :board

# json.lists @board.lists partial: 'lists/list', as: :list
