require 'sinatra'

empty=0
y="yes"
n="no"

cairn={"type"=>"tomb","name"=>"Barbarian Cairn"}
glade={"type"=>"trap","name"=>"Trap-Filled Glade"}
olegs={"type"=>"structure","name"=>"Oleg’s Trading Post"}
bokkens={"type"=>"hut","name"=>"Bokken's Hut"}
trapper={"type"=>"tomb","name"=>"Dead Trapper"}
fnest={"type"=>"monster","name"=>"Fairy Nest"}
rpatch={"type"=>"plant","name"=>"Radish Patch"}
spiders={"type"=>"monster","name"=>"Spider's Nest"}
frogpond={"type"=>"monster","name"=>"Frog Pond"}
temple={"type"=>"ruin","name"=>"Temple of Elk"}
trcamp={"type"=>"bridge","name"=>"Thorn River Camp"}
gmine={"type"=>"mine","name"=>"Gold Mine"}
fcache={"type"=>"tomb","name"=>"Forgotten Cache"}
statue={"type"=>"ruin","name"=>"Statue of Erastil"}
boggard={"type"=>"monster","name"=>"Boggard Lair"}
tgutter={"type"=>"monster","name"=>"Tuskgutter’s Lair"}
rbridge={"type"=>"bridge","name"=>"Rickety Bridge"}
sycamore={"type"=>"monster","name"=>"The Old Sycamore"}
nettles={"type"=>"bridge","name"=>"Nettle’s Crossing"}
unicorn={"type"=>"tomb","name"=>"Dead Unicorn"}
wyrm={"type"=>"bridge","name"=>"Tatzlwyrm’s Den"}
tcine={"type"=>"trap","name"=>"Trapped Thylacine"}
fberry={"type"=>"plant","name"=>"Fangberry Thicket"}
crossing={"type"=>"bridge","name"=>"River Crossing"}
kobolds={"type"=>"monster","name"=>"Sootscale Caverns"}
fort={"type"=>"structure","name"=>"Staglord’s Fort"}

events=[
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     cairn,    empty,    glade,    empty,    olegs,  bokkens,    empty ],
  [    empty,     empty,  trapper,    fnest,   rpatch,  spiders,    empty,    empty ],
  [    empty,     empty, frogpond,   temple,   trcamp,    gmine,   fcache,    empty ],
  [    empty,    statue,  boggard,  tgutter,  rbridge, sycamore,  nettles,    empty ],
  [    empty,   unicorn,     wyrm,    tcine,   fberry, crossing,  kobolds,    empty ],
  [    empty,     empty,    empty,    empty,     fort,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ]
]

# zero for unseen, "no" for seen but unexplored, "yes" for fully explored
discovery=[
  [ 0, 0, 0, 0, y, y, y, y ],
  [ 0, 0, 0, 0, 0, y, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0 ],
]

revealed=[
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
  [ y, y, y, y, y, y, y, y ],
]

set :static_cache_control, [:public, :must_revalidate, :max_age => 10]

get '/' do
  cache_control :public, :must_revalidate, :max_age => 60
  @page_title = "The Stolen Lands: The Greenbelt"
  @hex=events
  @exploration=discovery.dup
  @error_message=nil
  File.open("public/exploration.txt").each do |line|
    if line =~ /^\s*(?:\#.*)?$/
      # ignore comments and blank lines
    elsif line =~ /^\s*(\d+)-(\d+)\s+(unseen|seen|explored)\s*$/
      x=$1.to_i
      y=$2.to_i
      action=$3
      if action == "unseen"
        @exploration[x][y]=0
      elsif action == "seen"
        @exploration[x][y]="no"
      elsif action == "explored"
        @exploration[x][y]="yes"
      end
    elsif @error_message
      @error_message="#{@error_message}<br>invalid line in exploration.txt: #{line.inspect}"
    else
      @error_message="invalid line in exploration.txt: #{line.inspect}"
    end
  end
  erb :index
end

get '/all' do
  cache_control :public, :must_revalidate, :max_age => 60
  @page_title = "The Stolen Lands: The Greenbelt (ALL)"
  @hex=events
  @exploration=revealed
  erb :index
end

# get '/hexstatus/:row/:tile/:status' do
#   discovery[params[:row].to_i][params[:tile].to_i]=(params[:status] == "reset" ? 0 : params[:status])
#   "updated row:"+params[:row]+" tile:"+params[:tile]+" with "+params[:status]
# end


