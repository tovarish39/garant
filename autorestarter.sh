# export Garant_Path in .bashrc

source /root/.bashrc # ! changeble

ruby_path=$(which ruby)
bundle_path=$(which bundle)
rails_path=$(which rails)

pid_path_adminka=$Garant_Path/adminka/tmp/pids/server.pid
pid_path_bot_garant_main=$Garant_Path/garant-bots/tmp/main.pid
pid_path_bot_garant_moderator=$Garant_Path/garant-bots/tmp/moderator.pid
pid_path_bot_blackList_main=$Garant_Path/black_list-bots/tmp/main.pid
pid_path_bot_blackList_moderator=$Garant_Path/black_list-bots/tmp/moderator.pid

pid_adminka=$(head -n 1 $pid_path_adminka)
pid_garant_main=$(head -n 1 $pid_path_bot_garant_main)
pid_garant_moderator=$(head -n 1 $pid_path_bot_garant_moderator)
pid_blackList_main=$(head -n 1 $pid_path_bot_blackList_main)
pid_blackList_moderator=$(head -n 1 $pid_path_bot_blackList_moderator)

# adminka
if ! kill -0 $pid_adminka; then
    cd $Garant_Path/adminka
    $rails_path server &
fi


# garant
if ! kill -0 $pid_garant_main; then
    cd $Garant_Path/garant-bots
    $bundle_path exec $ruby_path main.rb &
fi

if ! kill -0 $pid_garant_moderator; then
    cd $Garant_Path/garant-bots
    $bundle_path exec $ruby_path moderator.rb &
fi

# blackList
if ! kill -0 $pid_blackList_main; then
    cd $Garant_Path/black_list-bots
    $bundle_path exec $ruby_path main.rb &
fi

if ! kill -0 $pid_blackList_main; then
    cd $Garant_Path/black_list-bots
    $bundle_path exec $ruby_path moderator.rb &
fi
