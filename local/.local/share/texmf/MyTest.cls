% MyTest.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MyTest}[2026/06/05 Classe de provas e listas.]

% Passa opções desconhecidas para a classe base (article, report, etc.)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Classe base
\LoadClass[landscape,a4paper,11pt,twoside,twocolumn]{article}

% Pacotes e configurações comuns
% \RequirePackage[T1]{fontenc}
% \RequirePackage[utf8]{inputenc} % se usar pdfLaTeX; com LuaLaTeX/XeLaTeX pode remover
% \RequirePackage[brazil]{babel}

\RequirePackage{geometry}
\geometry{margin=0.8in}

\RequirePackage{microtype}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  urlcolor=blue,
  citecolor=blue
}

% Exemplo de comando seu
% \newcommand{\meutitulo}[1]{\begin{center}\Large\bfseries #1\end{center}}
\renewcommand{\thesection}{Questão \arabic{section} \sectionname}
\renewcommand{\thesubsection}{(\alph{subsection})}
\endinput
