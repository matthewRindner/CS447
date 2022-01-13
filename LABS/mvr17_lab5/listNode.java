class ListNode {
 int data;
 ListNode next;
 public ListNode(int data) {
 this.data = data;
 this.next = null;
 }
 public static int[] testvalues = { 2, 6, 3, 0 };
 public void append(int data) {
 if (this.next==null) {
 this.next = new ListNode(data);
 } else {
 this.next.append(data);
 }
 }
 public void printlist() {
 // your job!
 }
 public void remove(int data) {
 // your job!
 }
 public static void main(String[] args) {
 ListNode head = new ListNode(testvalues[0]);
 for (int i=1; i<testvalues.length; i++) {
 head.append(testvalues[i]);
 }

 head.printlist();
 }
}
T