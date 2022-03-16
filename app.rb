require 'sinatra'

empty=0
cairn={"type"=>"tomb","name"=>"Barbarian Cairn"}
glade={"type"=>"trap","name"=>"Trap-Filled Glade"}
olegs={"type"=>"structure","name"=>"Oleg's Trading Post"}
bokkens={"type"=>"hut","name"=>"Bokken's Hut"}
trapper={"type"=>"tomb","name"=>"Dead Trapper"}
fnest={"type"=>"monster","name"=>"Fairy Nest"}
rpatch={"type"=>"plant","name"=>"Radish Patch"}
spiders={"type"=>"monster","name"=>"Spider's Nest"}
frogpond={"type"=>"landmark","name"=>"Frog Pond"}
temple={"type"=>"ruin","name"=>"Temple of Elk"}
trcamp={"type"=>"bridge","name"=>"Thorn River Camp"}


events=[
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     cairn,    empty,    glade,    empty,    olegs,  bokkens,    empty ],
  [    empty,     empty,  trapper,    fnest,   rpatch,  spiders,    empty,    empty ],
  [    empty,     empty, frogpond,   temple,   trcamp,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ]
]

# zero for unseen, "no" for seen but unexplored, "yes" for fully explored
discovery=[
  [0,0,0,0,"yes","yes","yes","yes"],
  [0,0,0,0,0,"yes",0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
]

set :static_cache_control, [:public, :must_revalidate, :max_age => 10]

get '/' do
  cache_control :public, :must_revalidate, :max_age => 60
  @page_title = "Test hex"
  @hex=events
  @exploration=discovery
  erb :index
end

# get '/hexstatus/:row/:tile/:status' do
#   discovery[params[:row].to_i][params[:tile].to_i]=(params[:status] == "reset" ? 0 : params[:status])
#   "updated row:"+params[:row]+" tile:"+params[:tile]+" with "+params[:status]
# end


