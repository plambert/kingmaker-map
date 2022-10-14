require 'sinatra'

empty=0
y="yes"
n="no"

barrow={"type"=>"landmark","name"=>"Lonely Barrow"}
boggard={"type"=>"monster","name"=>"Boggard Lair"}
bokkens={"type"=>"hut","name"=>"Bokken's Hut"}
cairn={"type"=>"tomb","name"=>"Barbarian Cairn"}
callhelp={"type"=>"monster","name"=>"A Call for Help"}
crackjaw={"type"=>"monster","name"=>"Old Crackjaw"}
crossing={"type"=>"bridge","name"=>"River Crossing"}
delicate={"type"=>"resource","name"=>"Delicate Situation"}
exped={"type"=>"camp","name"=>"Narthropple Expedition"}
fberry={"type"=>"plant","name"=>"Fangberry Thicket"}
fcache={"type"=>"tomb","name"=>"Forgotten Cache"}
ferry={"type"=>"bridge","name"=>"Abandonded Ferry Station"}
fnest={"type"=>"monster","name"=>"Fairy Nest"}
ford={"type"=>"bridge","name"=>"Gurdin River Ford"}
fort={"type"=>"structure","name"=>"Staglord’s Fort"}
frogpond={"type"=>"monster","name"=>"Frog Pond"}
giant={"type"=>"monster","name"=>"Wandering Giant"}
glade={"type"=>"trap","name"=>"Trap-Filled Glade"}
gmine={"type"=>"mine","name"=>"Gold Mine"}
grove={"type"=>"monster","name"=>"Grove of Tiressia"}
hargulka={"type"=>"lair","name"=>"Hargulka's Stronghold"}
hermit={"type"=>"hut","name"=>"Mad Hermit"}
hodagden={"type"=>"monster","name"=>"Hodag Den"}
hollow={"type"=>"plant","name"=>"Blighted Hollow"}
keep={"type"=>"ruin","name"=>"Abandoned Keep"}
kingfor={"type"=>"monster","name"=>"King of the Forest"}
kobolds={"type"=>"monster","name"=>"Sootscale Caverns"}
lizking={"type"=>"lair","name"=>"Lair of the Lizard King"}
mudbowl={"type"=>"resource","name"=>"The Mud Bowl"}
nettles={"type"=>"bridge","name"=>"Nettle’s Crossing"}
olegs={"type"=>"structure","name"=>"Oleg’s Trading Post"}
onprowl={"type"=>"monster","name"=>"On the Prowl"}
owlbear={"type"=>"monster","name"=>"Owlbear Lair"}
rbridge={"type"=>"bridge","name"=>"Rickety Bridge"}
rpatch={"type"=>"plant","name"=>"Radish Patch"}
spiders={"type"=>"monster","name"=>"Spider's Nest"}
statue={"type"=>"ruin","name"=>"Statue of Erastil"}
sycamore={"type"=>"monster","name"=>"The Old Sycamore"}
tcine={"type"=>"trap","name"=>"Trapped Thylacine"}
temple={"type"=>"ruin","name"=>"Temple of Elk"}
tgutter={"type"=>"monster","name"=>"Tuskgutter’s Lair"}
tower={"type"=>"ruin","name"=>"Candlemere Tower"}
trapper={"type"=>"tomb","name"=>"Dead Trapper"}
trcamp={"type"=>"bridge","name"=>"Thorn River Camp"}
unicorn={"type"=>"tomb","name"=>"Dead Unicorn"}
witch={"type"=>"hut","name"=>"Swamp Witch"}
wyrm={"type"=>"bridge","name"=>"Tatzlwyrm’s Den"}


events=[
  [    empty,     empty,    empty,    empty,    empty,    empty,    empty,    empty ],
  [    empty,     cairn,    empty,    glade,    empty,    olegs,  bokkens,    empty ],
  [    empty,     empty,  trapper,    fnest,   rpatch,  spiders,    empty,    empty ],
  [    empty,     empty, frogpond,   temple,   trcamp,    gmine,   fcache,    empty ],
  [    empty,    statue,  boggard,  tgutter,  rbridge, sycamore,  nettles,    empty ],
  [    empty,   unicorn,     wyrm,    tcine,   fberry, crossing,  kobolds,    empty ],
  [    empty,     grove, delicate,    exped,     fort,  onprowl,   barrow,    empty ],
  [    empty,      keep,   hollow,   hermit,    witch, crackjaw,     ford,    empty ],
  [ hodagden,     empty,  lizking,    tower,  mudbowl,    empty, callhelp,    empty ],
  [    empty,  hargulka,  kingfor,    empty,    giant,    ferry,  owlbear,    empty ],
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


