\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nexaie}[2026/04/24 NExAIE Journal Class]

\DeclareOption{onecolumn}{\PassOptionsToClass{onecolumn}{article}}
\DeclareOption{twocolumn}{\PassOptionsToClass{twocolumn}{article}}

\newif\if@review\@reviewfalse
\DeclareOption{review}{\@reviewtrue}

\newif\if@preprint\@preprintfalse
\DeclareOption{preprint}{\@preprinttrue}

\ExecuteOptions{twocolumn}
\ProcessOptions\relax
\LoadClass[10pt,letterpaper]{article}

% =========================
% PACKAGES
% =========================
\RequirePackage[margin=0.85in, top=1.2in, bottom=1in, headheight=30pt]{geometry}

\RequirePackage{microtype}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\let\Bbbk\relax
\RequirePackage{amsmath,amssymb}
\RequirePackage{newtxtext,newtxmath}

\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage[colorlinks=true,
                linkcolor=blue,
                citecolor=blue,
                urlcolor=blue,
                pdflang=en]{hyperref} % pdflang=en for screen readers
\RequirePackage{authblk}    % For multiple authors/affiliations
\RequirePackage{orcidlink} % For ORCID icons
\RequirePackage{etoolbox}  % For conditional checks
\RequirePackage{enumitem}  % For checklist styling
\RequirePackage{accsupp}   % For basic accessibility (alt-text)
\RequirePackage[style=apa, backend=biber]{biblatex}

\if@review
  \RequirePackage{lineno}
  \linenumbers
\fi

\if@preprint
  \RequirePackage[text=NExAIE\ PREPRINT, color={[gray]{0.92}}, scale=0.6]{draftwatermark}
\fi

\RequirePackage[title]{appendix}

% authblk configuration
\renewcommand\Authfont{\normalsize\bfseries}
\renewcommand\Affilfont{\small\itshape}
\setlength{\affilsep}{0.5em}
\renewcommand\Authands{, and }

% =========================
% COLORS
% =========================
\definecolor{nexaieblue}{HTML}{003366}
\definecolor{accentgray}{gray}{0.4}

% =========================
% HEADER / FOOTER
% =========================
\pagestyle{fancy}
\fancyhf{}
\lhead{\raisebox{-0.3\height}{\includegraphics[height=1.0cm]{media/logo.pdf}}}
\rhead{\small \textit{Nexus AI \& Education} \ \textbullet \ \ ISSN: \@issn \\ \small Vol. \@volume, Issue \@issue \ (\@pagerange)}
\cfoot{\small \copyright \ \the\year \ \textit{The Authors}. Published by \textbf{NExAIE}. \\ \small This is an open access article under the CC BY 4.0 license. \\ \vspace{2pt} Page \thepage}
\renewcommand{\headrulewidth}{0.4pt}

% =========================
% SECTION STYLE
% =========================
\titleformat{\section}
  {\large\bfseries\color{nexaieblue}}
  {\thesection}{0.5em}{}

\titleformat{\subsection}
  {\normalsize\bfseries}
  {\thesubsection}{0.5em}{}

% =========================
% CUSTOM COMMANDS
% =========================

\newcommand{\articleType}[1]{\def\@articleType{#1}}
\newcommand{\titleNexAIE}[1]{\def\@titleNexAIE{#1}}
\newcommand{\authorNexAIE}[1]{\def\@authorNexAIE{#1}}
\newcommand{\affiliationNexAIE}[1]{\def\@affiliationNexAIE{#1}}

\newcommand{\received}[1]{\def\@received{#1}}
\newcommand{\accepted}[1]{\def\@accepted{#1}}
\newcommand{\published}[1]{\def\@published{#1}}

\newcommand{\volume}[1]{\def\@volume{#1}}
\newcommand{\issue}[1]{\def\@issue{#1}}
\newcommand{\pagerange}[1]{\def\@pagerange{#1}}
\newcommand{\doi}[1]{\def\@doi{#1}}
\newcommand{\issn}[1]{\def\@issn{#1}}

\newcommand{\aiProtocol}[2]{\def\@aiProtocolID{#1}\def\@aiProtocolCite{#2}}
\newcommand{\aiModel}[1]{\def\@aiModel{#1}}

\newcommand{\funding}[1]{\def\@funding{#1}}
\newcommand{\contributions}[1]{\def\@contributions{#1}}
\newcommand{\dataAvailability}[1]{\def\@dataAvailability{#1}}

\newcommand{\orcid}[1]{\href{https://orcid.org/#1}{\orcidlink{#1}}}
\newcommand{\correspondingAuthor}[1]{\thanks{Corresponding author: #1}}

\newcommand{\graphicalAbstract}[1]{
  \vspace{10pt}
  \noindent \textbf{Graphical Abstract} \par\vspace{6pt}
  \begin{center}
    \includegraphics[width=\linewidth]{#1}
  \end{center}
  \vspace{10pt}
}

% Accessibility Figure Command (WCAG 2.1 / ADA compliant)
% Usage: \nexaieFigure{placement}{path}{caption}{alt-text}
\newcommand{\nexaieFigure}[4]{
  \begin{figure}[#1]
    \centering
    \BeginAccSupp{ActualText={#4}}
      \includegraphics[width=\linewidth]{#2}
    \EndAccSupp{}
    \caption{#3}
  \end{figure}
}

% =========================
% TITLE BLOCK
% =========================
\newcommand{\saythanks}{%
  \begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\@textsuperscript{\normalfont\@thefnmark}}%
  \long\def\@makefntext##1{\noindent\@makefnmark\hspace{6pt}##1}%
  \footnotesize\@thanks
  \endgroup
  \global\let\@thanks\@empty
}

\renewcommand{\maketitle}{
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \if@twocolumn
    \twocolumn[{%
      \centering
      {\small \textcolor{accentgray}{\@articleType}} \par\vspace{6pt}
      {\LARGE \textbf{\@titleNexAIE}} \par\vspace{10pt}
      {\normalsize \@author} \par\vspace{10pt}
      {\small
        \textbf{Received:} \@received \quad
        \textbf{Accepted:} \@accepted \quad
        \textbf{Published:} \@published
      } \par\vspace{6pt}
      {\small \textbf{DOI:} \href{https://doi.org/\@doi}{\@doi}} \par\vspace{10pt}
      \hrule\vspace{8pt}
      \begin{minipage}{0.9\textwidth}
        \small
        \textbf{AI-Human Review Disclosure} \\
        \textbf{Protocol:} \texttt{\@aiProtocolID} \ \parencite{\@aiProtocolCite} \\
        \textbf{Model:} \@aiModel \quad \textbf{Verification:} Section Editor Verified
      \end{minipage}
      \vspace{16pt}
    }]
  \else
    \begin{center}
      {\small \textcolor{accentgray}{\@articleType}} \par\vspace{6pt}
      {\LARGE \textbf{\@titleNexAIE}} \par\vspace{10pt}
      {\normalsize \@author} \par\vspace{10pt}
      {\small
        \textbf{Received:} \@received \quad
        \textbf{Accepted:} \@accepted \quad
        \textbf{Published:} \@published
      } \par\vspace{6pt}
      {\small \textbf{DOI:} \href{https://doi.org/\@doi}{\@doi}} \par\vspace{10pt}
      \hrule\vspace{8pt}
      \begin{minipage}{0.9\textwidth}
        \centering\small
        \textbf{AI-Human Review Disclosure} \\
        \textbf{Protocol:} \texttt{\@aiProtocolID} \ \parencite{\@aiProtocolCite} \\
        \textbf{Model:} \@aiModel \quad \textbf{Verification:} Section Editor Verified
      \end{minipage}
      \vspace{16pt}
    \end{center}
  \fi
  \saythanks
}

% =========================
% ABSTRACT
% =========================
\renewenvironment{abstract}{
\section*{Abstract}
\small
}{}

% =========================
% KEYWORDS
% =========================
\newcommand{\keywords}[1]{
\vspace{6pt}
\noindent \textbf{Keywords:} #1
}