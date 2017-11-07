function saxon
  set saxon_jar ~/.jars/saxon9he.jar
  set argc (count $argv)
  if test $argc -eq 2
    java -jar "$saxon_jar" -s:$argv[1] -xsl:$argv[2]
  else if test $argc -lt 2
    java -jar "$saxon_jar" $argv
  else
    java -jar "$saxon_jar" $argv[3..-1] -s:$argv[1] -xsl:$argv[2]
  end
end
