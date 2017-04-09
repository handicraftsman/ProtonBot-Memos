ProtonBot::Plugin.new do
  @name        = 'Memos'
  @version     = ProtonBot::Memos::VERSION
  @description = 'Memo plugin for ProtonBot'

  core.permhash['admin'] << 'clear-memos'

  core.help_add('memos', 'memo', 'memo <user> <memo>', 'Sends memo to given user')
  cmd(cmd: 'memo') do |dat|
    if dat[:split].length >= 2
      unless dat[:plug].users.include? dat[:split][0]
        dat.nreply 'No such user available!'
      else
        dat[:db].query('memos').ensure.insert(
          'host'    => dat[:plug].gethost(dat[:split][0]),
          'message' => dat[:split][1,dat[:split].length].join(' '),
          'by'      => dat[:nick]
        ).write.finish
        dat.nreply 'Thanks. I will remind them.'
      end
    else
      dat.reply ProtonBot::Messages::NotEnoughParameters
    end
  end.cooldown!(30)

  core.help_add('memos', 'clearmemos', 'clearmemos {users}', 
    'Clear all memos globally or for given users (they must be online)')
  cmd(cmd: 'clearmemos') do |dat|
    if dat[:split].empty?
      dat[:db].query('memos').ensure.delete.write.finish
      dat.nreply 'Done!'
    else
      dat[:split].each do |user|
        if dat[:plug].users.include? user
          host = dat[:plug].gethost(user)
          dat[:db].query('memos').ensure.delete('host' => host).write.finish
        else
          dat.nreply 'No such user: ' + user
        end
      end
      dat.nreply 'Done!'
    end
  end.perm!('clear-memos')

  hook(type: :privmsg) do |dat|
    memos = dat[:db].query('memos').ensure.select('host' => dat[:host]).finish
    unless memos.empty?
      memos.each do |memo|
        dat.reply("#{dat[:nick]}: #{memo['message']} [#{memo['by']}]")
      end
      dat[:db].query('memos').ensure.delete('host' => dat[:host]).write.finish
    end
  end
end