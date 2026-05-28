#![allow(unused)]
#[rustfmt::skip]
mod fastio {
use std::io::{self, BufWriter, Read, Write};

pub struct FastWriter { writer: BufWriter<io::Stdout> }

impl FastWriter {
    pub fn new() -> Self { Self { writer: BufWriter::new(io::stdout()) } }
    pub fn print(&mut self, s: impl std::fmt::Display) { write!(self.writer, "{} ", s).unwrap(); }
    pub fn println(&mut self, s: impl std::fmt::Display) { writeln!(self.writer, "{}", s).unwrap(); }
    pub fn debug(&mut self, s: impl std::fmt::Display) {
        #[cfg(debug_assertions)]
        eprintln!("{}", s);
    }
}

impl Write for FastWriter {
    fn write(&mut self, buf: &[u8]) -> io::Result<usize> { self.writer.write(buf) }
    fn flush(&mut self) -> io::Result<()> { self.writer.flush() }
}

pub struct FastReader<'a> { iter: std::str::SplitAsciiWhitespace<'a> }

impl<'a> FastReader<'a> {
    pub fn new(s: &'a str) -> Self { Self { iter: s.split_ascii_whitespace() } }
    pub fn next<T: std::str::FromStr>(&mut self) -> T where T::Err: std::fmt::Debug, {
        self.iter.next().unwrap().parse().unwrap()
    }
    pub fn int(&mut self) -> i32 { self.next() }
    pub fn long(&mut self) -> i64 { self.next() }
    pub fn double(&mut self) -> f64 { self.next() }
    pub fn string(&mut self) -> String { self.next() }
    pub fn char(&mut self) -> char { self.next() }
    pub fn int_array(&mut self, n: usize) -> Vec<i32> { (0..n).map(|_| self.int()).collect() }
    pub fn long_array(&mut self, n: usize) -> Vec<i64> { (0..n).map(|_| self.long()).collect() }
    pub fn double_array(&mut self, n: usize) -> Vec<f64> { (0..n).map(|_| self.double()).collect() }
    pub fn string_array(&mut self, n: usize) -> Vec<String> { (0..n).map(|_| self.string()).collect() }
}
}
use fastio::{FastReader, FastWriter};
use std::io::{self, Read};

const INF: i64 = i64::MAX / 2;
const INF32: i32 = i32::MAX / 2;
const MOD: i64 = 1_000_000_007;
const EPS: f64 = 1e-9;

fn solution(_tcn: i32, fs: &mut FastReader, fw: &mut FastWriter) {}

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).unwrap();
    let mut fs = FastReader::new(&input);
    let mut fw = FastWriter::new();

    let tc = fs.int();
    for t in 0..tc {
        solution(t, &mut fs, &mut fw);
    }
}
