include ActionView::Helpers

Song.destroy_all
Timeline.destroy_all
Segment.destroy_all
Note.destroy_all
Soundboard.destroy_all
Sample.destroy_all

s1 = Song.create(:title => 'do be do', :duration => '90000', :share_url => 'sdkjfeiJKfn3' )
s2 = Song.create(:title => 'do do be do da do', :duration => '1000000', :share_url => 'kvEpdk2h9HP1' )
s3 = Song.create(:title => 'Great Ballz of le Fire', :duration => '80000', :share_url => '8Hkpdi9knel9' )

tl1 = Timeline.create
tl2 = Timeline.create
tl3 = Timeline.create

s1_1 = Segment.create(:duration => 1000, :start_time => 0)
s1_2 = Segment.create(:duration => 7000, :start_time => 400)
s2_1 = Segment.create(:duration => 12000, :start_time => 900)
s3_1 = Segment.create(:duration => 120, :start_time => 0)
s3_2 = Segment.create(:duration => 1000, :start_time => 700)

n1 = Note.create(:point_in_segment => 20, :sample_path => audio_path('u.wav') )
n2 = Note.create(:point_in_segment => 90, :sample_path => audio_path('semicolon.wav') )
n3 = Note.create(:point_in_segment => 50, :sample_path => audio_path('slash.wav') )
s1_1.notes << n1 << n2
s1_2.notes << n3

tl1.segments << s1_1 << s1_2
tl2.segments << s2_1
tl3.segments << s3_1 << s3_2

s1.timelines << tl1 << tl3

s2.timelines << tl2
