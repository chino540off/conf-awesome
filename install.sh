#! /bin/zsh

ROUGE="\033[31;01m"
VERT="\033[32;01m"
JAUNE="\033[33;01m"
BLEU="\033[34;01m"
MAGENTA="\033[35;01m"
CYAN="\033[36;01m"
BLANC="\033[37;01m"
NEUTRE="\033[0m"

echo "Awesome Install..."

rm ~/.config/awesome
ln -s $PWD ~/.config/awesome
echo -en "${VERT}*${NEUTRE}  awesome linked\t"
echo -e "${BLEU}[${VERT}OK${BLEU}]${NEUTRE}"

echo -e "Done."
