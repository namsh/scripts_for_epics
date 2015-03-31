#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


alias vi='vim'
alias du='du -h'
alias df='df -kh'


#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias mv='mv -i'
alias cp='cp -i'


alias p5="ps -eo user,pcpu,pid,cmd | sort -r -k2 | head -6"


# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'


alias epicsenv=". ~/epics/R3.14.12.5/setEpicsEnv.sh"


goApps() {
#	 . ~/epics/R3.14.12.5/setEpicsEnv.sh	
	 cd $RAON_SITEAPPS
	 cd $1
}


goKeithley(){
	goApps keithley6514
}

goIoc() {
	goApps $1
	cd iocBoot/ioc$1
}

runIoc() {
      	 goIoc $1
	 ./st.cmd
 	 
}