-- Read the contents of clipboard
-- Ref: http://stackoverflow.com/questions/1712347/closest-equivalent-to-subprocess-communicate-in-haskell
import System.Process
 
processPaste :: (String -> String) -> IO ()
processPaste pd = do
    let cmd = "pbpaste"
        args = []
        instr = []
    (rc, out, err) <- readProcessWithExitCode cmd args instr
    putStrLn $ pd out
