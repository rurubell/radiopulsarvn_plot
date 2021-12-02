#!/usr/bin/perl


#Скрипт для добавления кавычек в скрипт-текст


use strict;
use warnings;
use utf8;
use Encode qw(decode encode);

binmode(STDOUT,':utf8');
binmode(STDIN,':utf8');


#Путь до оригинального файла с текстом
my $S_IN_FILE_PATH = $ARGV[ 0 ];
if( index( $S_IN_FILE_PATH, ".rpy" ) == -1 ) { die "Wrong input file format (not *.rpy)..." }


#Get utf8 file as array of lines
sub readUTF8FileAsStringArr
{
	my $s_file_path = shift();
	open( my $file, '<:encoding( utf8 )', $s_file_path ) or die "Can't open file " . $s_file_path . "!\n";
	
	my @s_arr_of_lines = <$file>;
	chomp( @s_arr_of_lines );
	
	close( $file );
	return @s_arr_of_lines;
}


#В строке одни табы и пробелы?
sub isOnlySpacesAndTabsInString
{
	my $s_string = shift();
	
	for( my $i = 0; $i < length( $s_string ); $i++ )
	{
		my $s_char = substr( $s_string, $i, 1 );
		if( ( $s_char ne " " ) and ( $s_char ne "\t" ) ) { return undef; }
	}
	
	return 1;
}

#В строке есть служебные слова?
sub isStringContainsServiceWords
{
	my $s_string = shift();
	
	#Список служебных слов, строки с которыми будут проигнорированы
	my @s_service_words_arr = 
	(
		"label",
		"start",
		"init",
		"python",
		"image",
		"define",
		"show",
		"scene",
		"hide",
		"None",
		"return"
	);
	
	for( my $i = 0; $i < @s_service_words_arr; $i++ )
	{
		if( index( $s_string, $s_service_words_arr[ $i ] ) != -1 ) { return 1; }
	}
	
	return undef;
}


my @s_file_strings = readUTF8FileAsStringArr( $S_IN_FILE_PATH );

for( my $i = 0; $i < @s_file_strings; $i++ )
{
	if( index( $s_file_strings[ $i ], "#" ) != -1 ) { print( $s_file_strings[ $i ] . "\n" ); next; } #Печатаем строки с "#" без изменений
	if( length( $s_file_strings[ $i ] ) <= 0 ) { print( $s_file_strings[ $i ] . "\n" ); next; } #Печатаем строки нулевой длинны без изменений
	if( index( $s_file_strings[ $i ], "\"" ) != -1 ) { print( $s_file_strings[ $i ] . "\n" ); next; } #печатаем строки с кавычками без изменений
	if( isOnlySpacesAndTabsInString( $s_file_strings[ $i ] ) ) { print( "\n" ); next; } #Печатаем строки с одними пробелами/табами как строки нулевой длинны
	if( isStringContainsServiceWords( $s_file_strings[ $i ] ) ) { print( $s_file_strings[ $i ] . "\n" ); next; } #Печатаем строку с сервисными словами без кавычек
	
	print( "\"" .  $s_file_strings[ $i ] . "\"\n" ); #Добавляем кавычки к остальным строчкам
}
