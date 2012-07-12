Transcoder.format :mp4,
  resolution:    '1080x1920',
  audio_codec:   'aac', 
  audio_bitrate: '160k', 
  video_codec:   'libx264', 
  video_preset:  'slow', 
  video_preset:  'iPod640', 
  video_bitrate: '1500k', 
  threads:        0,
  custom:         '-strict -2'
  
Transcoder.format :webm,
  format:        'webm',
  resolution:    '1080x1920',
  audio_codec:   'libvorbis', 
  audio_bitrate: '160k', 
  video_codec:   'libvpx',
  video_bitrate: '1500k', 
  threads:        0,
  custom:         '-strict -2'


