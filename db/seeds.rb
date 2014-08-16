Song.destroy_all
Track.destroy_all
Note.destroy_all
Soundboard.destroy_all
Sample.destroy_all

s1 = Song.create(:title => 'do be do', :duration => '90000', :share_url => 'sdkjfeiJKfn3' )
s2 = Song.create(:title => 'do do be do da do', :duration => '1000000', :share_url => 'kvEpdk2h9HP1' )
s3 = Song.create(:title => 'Great Ballz of le Fire', :duration => '80000', :share_url => '8Hkpdi9knel9' )


t1_1 = Track.create(:duration => 5000)

t1_2 = Track.create(:duration => 7000)

t2_1 = Track.create(:duration => 12000)

s1.tracks << t1_1 << t1_2

s2.tracks << t2_1

