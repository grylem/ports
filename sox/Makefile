include ../defaults.mk

NAME		= sox
VERSION		= 14.4.2

DESCRIPTION	= the Swiss Army knife of audio manipulation
HOMEPAGE	= https://sox.sourceforge.net/
DOWNLOAD	= https://sourceforge.net/projects/sox/files/sox/$(VERSION)/

CONFIGURE_ARGS +=			\
		--disable-openmp	\
		--enable-symlinks	\
		--without-libltdl	\
		--with-magic		\
		--without-png		\
		--without-ladspa	\
		--without-mad		\
		--without-id3tag	\
		--without-lame		\
		--without-twolame	\
		--with-oggvorbis	\
		--with-opus		\
		--with-flac		\
		--without-amrwb		\
		--without-amrnb		\
		--without-wavpack	\
		--with-sndfile		\
		--without-mp3		\
		--without-gsm		\
		--without-lpc10		\
		--with-coreaudio	\
		--without-sndio		\
		--without-alsa		\
		--without-ao		\
		--without-pulseaudio	\
		--without-waveaudio	\
		--without-oss		\
		--without-sunaudio

include ../port.mk
