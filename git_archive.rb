# Step 1: create an archive repo.
# Step 2: put this script in that archive.
# Step 3: call  "ruby git_archive.rb <repo> <remoteUrl>" from the
# commeand line, where repo is the name of the repo and remoteURL is its
# github url.
# Step 4: push to github.
# Repeat 3-4 for each repo you want in the archive.


repo = ARGV[0]
remoteUrl = ARGV[1]

if !(repo && remoteUrl)
  puts "Improper arguments! Come on guys!"
  return
end

puts `git remote add -f #{repo} #{remoteUrl}`
puts `git merge -s ours --no-commit #{repo}/master`
puts `git read-tree --prefix=#{repo}/ -u #{repo}/master`
puts `git commit -m "Subtree merged in #{repo}"`
