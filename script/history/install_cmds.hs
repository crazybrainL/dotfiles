import Data.List
import System.Cmd

type ExecuteCmd = String 
type Option = String
type OptionList = [Option]

data Command = Cmd ExecuteCmd OptionList
    deriving (Show, Eq)

brewTapList :: [OptionList]
brewTapList = makePackageList $ words "homebrew/science homebrew/dupes phinze/cask"

brewPackageList :: [OptionList]
brewPackageList = makePackageList $ words "brew-cask zsh zsh-syntax-highlighting \
\zsh-completions haskell-platform wget unrar cgdb make vim p7zip gnu-time \
\gnu-which gnuplot sshfs grep sqlite tig doxygen graphviz findutils gnu-getopt \
\ctags cscope git gnu-tar tmux screen swig osxfuse opencc cmake lftp vagrant freetype\
\gfortran libpng ffmpeg zeromq zsh-completions"

brewPackageWithOptionList :: [OptionList]
brewPackageWithOptionList = makePackageList ["vim --with-lua",
                                             "macvim --with-lua",
                                             "python --with-brewed-openssl",
                                             "python3 --with-brewed-openssl"]

pipPacakgeList :: [OptionList]
pipPacakgeList = makePackageList $ words "cython ipython mpmath pylint flask \
\ nikola markdown numpy scipy scikit-learn matplotlib nltk flake8 nosetest zeromq \
\ pyzmq Tornado jinja2 pylab" 

cabalPackageList :: [OptionList]
cabalPackageList = makePackageList $ words "pandoc hakyll agda idris happy cpphs ihaskell"


remainCmd :: String
remainCmd = "sudo rm -rf /usr/bin/tar \n\
\sudo ln -s /usr/local/bin/gtar /usr/bin/tar \n\
\sudo rm -rf /usr/bin/ctags \n\
\sudo ln -s /usr/local/bin/ctags /usr/bin/ctags \n\
\brew linkapps"

installCmdPackageList :: [(ExecuteCmd, Option, [OptionList])]
installCmdPackageList = [("brew", "tap", brewTapList),
                         ("brew", "install", brewPackageList),
                         ("brew", "install", brewPackageWithOptionList),
                         ("pip", "install", pipPacakgeList),
                         ("cabal", "install", cabalPackageList)] 

makePackageList :: [String] -> [OptionList]
makePackageList pl = Data.List.nub $ map words pl

commandStr :: Command -> String
commandStr (Cmd ecmd ol) = ecmd ++ " " ++ foldr (\x y-> x ++ " " ++ y) "" ol

makeCmdList :: ExecuteCmd -> Option -> [OptionList] -> [Command]
makeCmdList ecmd op = map (\x -> Cmd ecmd (op : x)) 

uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) = f a b c 

makeAllCmds :: [(ExecuteCmd, Option, [OptionList])] -> [Command]
makeAllCmds = concatMap (uncurry3 makeCmdList) 

executeEchoCmd :: String -> IO()
executeEchoCmd c =
    do
        putStrLn c
        System.Cmd.system c
        return ()

main :: IO()
main = 
    do
        let cmd_list = makeAllCmds installCmdPackageList
        mapM_ (executeEchoCmd . commandStr) cmd_list
        mapM_ executeEchoCmd $ lines remainCmd 
        
